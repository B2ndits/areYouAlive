import { sms } from '@kit.TelephonyKit';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 短信服务类
 */
export class SmsService {
  /**
   * 发送求救短信
   * @param phoneNumber 紧急联系人电话
   * @param userName 用户姓名
   * @param lastSignInTime 最后签到时间
   * @param location 最后签到位置（经纬度）
   */
  static async sendEmergencySms(
    phoneNumber: string,
    userName: string,
    lastSignInTime: string,
    location: string
  ): Promise<boolean> {
    try {
      // 构建短信内容
      const message = `我是${userName}，我可能有点死了！ 本人已经整整48小时未在活着吗APP签到，麻烦尽快前来协助！\n最后签到时间：${lastSignInTime}。\n最后签到位置：${location}。`;

      // 发送短信
      sms.sendMessage({
        slotId: 0,
        destinationHost: phoneNumber,
        content: message
      });

      console.info('短信发送请求已提交');
      return true;
    } catch (err) {
      const error = err as BusinessError;
      console.error(`发送短信异常: code=${error.code}, message=${error.message}`);
      return false;
    }
  }
}
