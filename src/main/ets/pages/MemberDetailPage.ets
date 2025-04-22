import { router } from '@kit.ArkUI'
import { ConsumptionRecord, Member } from '../common/common'

@Entry
@Component
struct MemberDetailPage {

  @State member: Member = router.getParams() as Member


  build() {
    Column() {
      Text("会员详情")
        .fontSize(24)
        .margin(16)

      Scroll() {
        Column() {
          // 基本信息
          Column() {
            Text(this.member.name)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Text(`电话: ${this.member.phone}`)
            Text(`当前积分: ${this.member.points}`)
              .fontColor("#ff8800")
          }
          .padding(12)
          .backgroundColor("#f5f5f5")
          .borderRadius(8)
          .margin({ bottom: 16 })

          // 消费记录
          Text("消费记录")
            .fontSize(18)
            .margin({ bottom: 8 })

          ForEach(this.member.consumptionRecords, (record: ConsumptionRecord) => {
            Column() {
              Row() {
                Column() {
                  Text(record.date)
                    .fontColor("#666")
                  Text(record.description)
                }
                .layoutWeight(1)

                Text(`¥${record.amount.toFixed(2)}`)
                  .fontColor("#00c853")
              }
              .padding(8)
              Divider()
            }
          })

          if (this.member.consumptionRecords.length === 0) {
            Text("暂无消费记录")
              .fontColor("#999")
              .margin({ top: 16 })
          }
        }
        .padding(16)
      }
      .scrollable(ScrollDirection.Vertical)
    }
    .width('100%')
    .height('100%')
  }
}