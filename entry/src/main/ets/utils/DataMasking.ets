/**
 * 数据脱敏工具类
 */
export class DataMasking {
  /**
   * 姓名脱敏
   * 只显示第一位，后面用**代替，最多显示两个*
   * @param name 原始姓名
   * @returns 脱敏后的姓名
   */
  static maskName(name: string): string {
    if (!name || name.length === 0) {
      return '';
    }
    // 只显示第一位，后面用**代替
    return name.charAt(0) + '**';
  }

  /**
   * 手机号脱敏
   * 中间四位用*号代替
   * @param phone 原始手机号
   * @returns 脱敏后的手机号
   */
  static maskPhone(phone: string): string {
    if (!phone || phone.length < 7) {
      return phone;
    }
    // 保留前三位和后四位，中间用****代替
    const visibleLength = 4;
    const startLength = 3;
    return phone.substring(0, startLength) + '****' + phone.substring(phone.length - visibleLength);
  }
}
