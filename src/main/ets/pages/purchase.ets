
import { router } from '@kit.ArkUI'
import { Product } from '../common/common'


@Entry
@Component
struct GoodsDetailPage {
  // 商品实例
  @State product: Product = router.getParams() as Product

  // 购买状态
  @State quantity: number = 1
  @State selectedPayment: number = 0
  @State totalPrice: number = this.product.price * this.quantity

  // 支付方式
  private paymentMethods: string[] = [
    "微信支付",
    "支付宝支付",
    "云闪付",
    "信用卡支付"
  ]

  build() {
    // 正确根节点结构
    Column() { // 使用Column作为根容器
      Scroll() { // 使用Scroll替代ScrollView
        Column() {
          // 商品信息区块
          this.buildProductInfo()

          this.buildQuantityControl()

          this.buildPaymentSelection()
        }
        .padding(12)
      }
      .scrollable(ScrollDirection.Vertical) // 设置滚动方向

      this. buildActionBar()
      // 底部结算栏（保持在可视区域）
      this.buildBottomBar()
    }
  }

  // 商品信息区块
  @Builder
  buildProductInfo() {
    Column() {
      Text(this.product.name)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 8 })

      Row() {
        Text("售价：")
          .fontColor("#666")
        Text(`¥${this.product.price.toFixed(2)}`)
          .fontColor("#ff5500")
          .fontSize(22)
      }

      Row() {
        Text("库存：")
          .fontColor("#666")
        Text(`${this.product.stock}件`)
          .fontColor("#333")
      }
      .margin({ top: 6 })
    }
    .padding(12)
    .borderRadius(8)
    .backgroundColor("#f8f8f8")
    .margin({ bottom: 20 })
  }

  // 数量选择组件
  @Builder
  buildQuantityControl() {
    Column() {
      Row() {
        Text("购买数量")
          .fontSize(16)

        Row() {
          Button('-')
            .width(32)
            .height(32)
            .fontSize(18)
            .onClick(() => {
              if (this.quantity > 1) {
                this.quantity--
                this.updateTotal()
              }
            })

          Text(this.quantity.toString())
            .width(48)
            .textAlign(TextAlign.Center)
            .fontSize(18)

          Button('+')
            .width(32)
            .height(32)
            .fontSize(18)
            .onClick(() => {
              if (this.quantity < this.product.stock) {
                this.quantity++
                this.updateTotal()
              }
            })
        }
        .margin({ left: 20 })
      }
      .justifyContent(FlexAlign.SpaceBetween)

      Text(this.quantity === this.product.stock ? "已达最大库存" : "")
        .fontColor("#ff5500")
        .fontSize(12)
        .margin({ top: 4 })
    }
    .padding(12)
    .backgroundColor(Color.White)
    .margin({ bottom: 15 })
  }

  // 支付方式选择
  @Builder
  buildPaymentSelection() {
    Column() {
      Text("支付方式")
        .fontSize(18)
        .margin({ bottom: 12 })

      ForEach(this.paymentMethods, (method: string, index) => {
        Row() {
          Radio({ value: String(index), group: "payments" })
            .checked(this.selectedPayment === index)
            .onChange((checked) => {
              if (checked) this.selectedPayment = index
            })

          Text(method)
            .margin({ left: 8 })
            .fontSize(16)
        }
        .margin({ bottom: 10 })
      })
    }
    .padding(12)
    .backgroundColor(Color.White)
  }

  // 底部操作栏
  @Builder
  buildActionBar() {
    Row() {
      Column() {
        Text("合计金额")
          .fontSize(14)
          .fontColor("#666")
        Text(`¥${this.totalPrice.toFixed(2)}`)
          .fontSize(22)
          .fontColor("#ff5500")
      }
      .layoutWeight(1)

      Button("立即支付")
        .width(160)
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor("#ff5500")
        .onClick(() => this.handlePayment())
    }
    .padding(12)
    .width('100%')
    .backgroundColor(Color.White)
    .shadow({ radius: 4 })
    .position({ y: '100% - 80' })
  }

  // 更新总价
  updateTotal() {
    this.totalPrice = this.product.price * this.quantity
  }

  // 支付处理
  handlePayment() {
    // 实际支付逻辑需要对接支付SDK
    console.log(`
      发起支付请求：
      商品ID：${this.product.id}
      数量：${this.quantity}
      总金额：${this.totalPrice}
      支付方式：${this.paymentMethods[this.selectedPayment]}
    `)
  }
  @Builder
  buildBottomBar() {
    Row() {
      // ...原有结算内容不变...
    }
    .padding(12)
    .backgroundColor(Color.White)
    .shadow({ radius: 4 })
    // 移除position定位，通过外层Column自动布局
    .width('100%')
  }
}