import { router } from '@kit.ArkUI'
import { ConsumptionRecord, Member } from '../common/common'




// 模拟数据源
const mockMembers: Member[] = [
  new Member(1, "张三", "13800138000", 1500, [
    new ConsumptionRecord("2024-03-15", 299, "电子产品购买"),
    new ConsumptionRecord("2024-03-18", 150, "餐饮消费")
  ]),
  new Member(2, "李四", "13912345678", 2300, [
    new ConsumptionRecord("2024-03-20", 899, "服饰购物")
  ]),
  new Member(3, "王五", "13698765432", 500, [])
];

// 会员列表页面
// 子组件 - 会员列表项
@Component
struct MemberListItem {
  // 接收父组件传递的会员数据
  @Prop member: Member

  build() {
    Column() {
      Row() {
        // 左侧信息区
        Column() {
          Text(this.member.name)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Text(`电话: ${this.member.phone}`)
            .fontColor("#666")
            .margin({ top: 4 })
        }
        .layoutWeight(1)

        // 右侧操作区
        Column() {
          Text(`${this.member.points}积分`)
            .fontColor("#ff8800")

          Button("详情")
            .type(ButtonType.Capsule)
            .width(80)
            .margin({ top: 8 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/MemberDetailPage', // 目标页面路径，需与项目目录一致
                params: this.member

              })
            })
        }
      }
      .padding(12)

      Divider()
    }
  }
}

// 父组件 - 会员列表页
@Entry
@Component
struct MemberListPage {
  @State members: Member[] = mockMembers

  build() {
    Column() {
      Text("会员列表")
        .fontSize(24)
        .margin(16)

      Scroll() {
        Column() {
          ForEach(this.members, (item: Member) => {
            ListItem() {
              MemberListItem({
                member : item
              })
                .margin({ top: 20 })
            }
          }, (item: Member) => item.id.toString())
        }
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
    }
    .width('100%')
    .height('100%')
  }
}