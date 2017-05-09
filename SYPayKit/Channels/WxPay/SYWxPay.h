//
//  SYWxPay.h
//  Pods
//  业务流程：https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=8_3
//  Created by Allen on 09/05/2017.
//
//

//商户系统和微信支付系统主要交互说明：
//步骤1：用户在商户APP中选择商品，提交订单，选择微信支付。
//步骤2：商户后台收到用户支付单，调用微信支付统一下单接口。参见【统一下单API】。
//步骤3：统一下单接口返回正常的prepay_id，再按签名规范重新生成签名后，将数据传输给APP。参与签名的字段名为appId，partnerId，prepayId，nonceStr，timeStamp，package。注意：package的值格式为Sign=WXPay
//步骤4：商户APP调起微信支付。api参见本章节【app端开发步骤说明】
//步骤5：商户后台接收支付通知。api参见【支付结果通知API】
//步骤6：商户后台查询支付结果。，api参见【查询订单API】

//说明：商品后台完成步骤3后，客户端执行步骤4，5，支付成功后，去商品后台查询支付结果步骤6

#import "SYPayment.h"

@interface SYWxPay : SYPayment

@end
