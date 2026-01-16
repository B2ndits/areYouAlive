import { workScheduler } from '@kit.BackgroundTasksKit';
import { preferences } from '@kit.ArkData';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { SmsService } from './SmsService';
import { common } from '@kit.AbilityKit';

const DOMAIN = 0x0000;
const TAG = 'WorkSchedulerService';

/**
 * 位置信息接口
 */
interface LocationData {
  latitude: number;
  longitude: number;
}

/**
 * WorkScheduler 服务类
 * 用于每小时定时检查并发送求救短信（如果超过48小时未签到）
 */
export class WorkSchedulerService {
  /**
   * 启动定时任务（每小时执行一次）
   */
  static async startPeriodicTask(): Promise<void> {
    try {
      const workInfo: workScheduler.WorkInfo = {
        workId: 1,
        bundleName: 'com.example.areyoualive', // 应用的 bundle name
        abilityName: 'EntryAbility',
        repeatCycleTime: 60 * 60 * 1000, // 重复间隔（毫秒）- 1小时
        isPersisted: true, // 是否持久化（重启后继续）
        parameters: {
          taskType: 'checkEmergency'
        }
      };

      workScheduler.startWork(workInfo);
      hilog.info(DOMAIN, TAG, 'WorkScheduler 定时任务启动成功');
    } catch (err) {
      const error = err as BusinessError;
      hilog.error(DOMAIN, TAG, `WorkScheduler 启动失败: code=${error.code}, message=${error.message}`);
    }
  }

  /**
   * 停止定时任务
   */
  static async stopPeriodicTask(): Promise<void> {
    try {
      const workInfo: workScheduler.WorkInfo = {
        workId: 1,
        bundleName: 'com.example.areyoualive',
        abilityName: 'EntryAbility'
      };
      workScheduler.stopWork(workInfo);
      hilog.info(DOMAIN, TAG, 'WorkScheduler 定时任务已停止');
    } catch (err) {
      const error = err as BusinessError;
      hilog.error(DOMAIN, TAG, `WorkScheduler 停止失败: code=${error.code}, message=${error.message}`);
    }
  }

  /**
   * 检查并发送求救短信
   * 这个方法将在 WorkScheduler 回调中被调用
   */
  static async checkAndSendEmergencySms(context: common.UIAbilityContext): Promise<void> {
    try {
      hilog.info(DOMAIN, TAG, '开始检查是否需要发送求救短信');

      // 获取存储的用户数据
      const storage = await preferences.getPreferences(context, 'user_data');
      const isSignIn = await storage.get('isSignIn', false) as boolean;
      const lastSignInTimestamp = await storage.get('lastSignInTimestamp', 0) as number;
      const userName = await storage.get('userName', '') as string;
      const phone = await storage.get('Phone', '') as string;
      const lastSignInTime = await storage.get('Time', '') as string;
      const locationStr = await storage.get('lastSignInLocation', '') as string;

      // 检查是否有必要的签到信息
      if (!isSignIn || lastSignInTimestamp === 0) {
        hilog.info(DOMAIN, TAG, '用户尚未签到，无需检查');
        return;
      }

      // 计算距离上次签到的时间（毫秒）
      const currentTime = Date.now();
      const timeSinceLastSignIn = currentTime - lastSignInTimestamp;

      // 48小时 = 48 * 60 * 60 * 1000 = 172800000 毫秒
      const fortyEightHours = 48 * 60 * 60 * 1000;

      hilog.info(DOMAIN, TAG, `距离上次签到: ${Math.floor(timeSinceLastSignIn / 1000 / 60 / 60)} 小时`);

      // 如果超过48小时，发送短信
      if (timeSinceLastSignIn > fortyEightHours) {
        hilog.info(DOMAIN, TAG, '超过48小时未签到，准备发送求救短信');

        // 解析位置信息
        let location = '';
        if (locationStr) {
          try {
            const locationData: LocationData = JSON.parse(locationStr) as LocationData;
            location = `${locationData.latitude.toFixed(6)},${locationData.longitude.toFixed(6)}`;
          } catch (e) {
            hilog.error(DOMAIN, TAG, '解析位置信息失败: %{public}s', JSON.stringify(e));
            location = locationStr;
          }
        }

        // 发送求救短信
        await SmsService.sendEmergencySms(phone, userName, lastSignInTime, location);
        hilog.info(DOMAIN, TAG, '已发送48小时未签到求救短信');
      } else {
        hilog.info(DOMAIN, TAG, '未超过48小时，无需发送短信');
      }
    } catch (err) {
      hilog.error(DOMAIN, TAG, `检查求救短信失败: %{public}s`, JSON.stringify(err));
    }
  }
}
