

@Observed
export class Product{
  superId : number ;
  id : number ;
  name : string ;
  price : number ;
  stock : number ;
  category : string ;
  imageUrl : Resource ;

  constructor(superId:number,id:number, name:string, price: number, stock: number ,category : string,imageUrl : Resource  ) {
    this.superId=superId
    this.id=id
    this.name=name
    this.price=price
    this.stock=stock
    this.category =category
    this.imageUrl=imageUrl
  }
}

// 消费记录类
export class ConsumptionRecord {
  date: string
  amount: number
  description: string
  constructor(date: string, amount: number, description: string) {
    this.date=date
    this.amount=amount
    this.description=description
  }
}

// 会员信息类
export class Member {
  id: number
  name: string
  phone: string
  points: number
  consumptionRecords: ConsumptionRecord[] = []
  constructor(id: number, name: string, phone: string, points: number, consumptionRecords: ConsumptionRecord[]
  ) {
    this.id=id;
    this.name=name;
    this.phone=phone;
    this.points=points;
    this.consumptionRecords=consumptionRecords
  }
}


