import { geoLocationManager } from '@kit.LocationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { abilityAccessCtrl, Permissions } from '@kit.AbilityKit';

/**
 * 位置信息接口
 */
export interface LocationInfo {
  latitude: number;  // 纬度
  longitude: number; // 经度
  timestamp: number; // 时间戳
}

/**
 * 位置服务类
 */
export class LocationService {
  /**
   * 请求位置权限
   * @param context 上下文
   */
  static async requestLocationPermission(context: Context): Promise<boolean> {
    try {
      const atManager = abilityAccessCtrl.createAtManager();
      const permissions: Array<Permissions> = [
        'ohos.permission.APPROXIMATELY_LOCATION',
        'ohos.permission.LOCATION'
      ];

      // 请求权限
      atManager.requestPermissionsFromUser(context, permissions)
        .then((data) => {
          const authResults = data.authResults;
          for (let i = 0; i < authResults.length; i++) {
            if (authResults[i] !== 0) {
              console.error(`权限 ${permissions[i]} 授权失败`);
              return false;
            }
          }
          console.info('位置权限授权成功');
          return true;
        })
        .catch((err: BusinessError) => {
          console.error(`请求权限失败: code=${err.code}, message=${err.message}`);
          return false;
        });

      return true;
    } catch (err) {
      const error = err as BusinessError;
      console.error(`请求权限异常: code=${error.code}, message=${error.message}`);
      return false;
    }
  }

  /**
   * 获取当前位置
   * @returns 位置信息
   */
  static async getCurrentLocation(): Promise<LocationInfo | null> {
    try {
      // 请求定位权限
      const requestInfo: geoLocationManager.LocationRequest = {
        'priority': geoLocationManager.LocationRequestPriority.ACCURACY,
        'scenario': geoLocationManager.LocationRequestScenario.UNSET,
        'timeInterval': 1,
        'distanceInterval': 0,
        'maxAccuracy': 0
      };

      // 获取位置
      const location: geoLocationManager.Location = await geoLocationManager.getCurrentLocation(requestInfo);

      if (location) {
        return {
          latitude: location.latitude,
          longitude: location.longitude,
          timestamp: Date.now()
        };
      }

      return null;
    } catch (err) {
      const error = err as BusinessError;
      console.error(`获取位置失败: code=${error.code}, message=${error.message}`);
      return null;
    }
  }

  /**
   * 格式化位置信息为字符串
   * @param location 位置信息
   * @returns 格式化的位置字符串
   */
  static formatLocation(location: LocationInfo): string {
    return `${location.latitude.toFixed(6)},${location.longitude.toFixed(6)}`;
  }
}
