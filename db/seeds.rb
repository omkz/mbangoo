OrderStatus.delete_all
OrderStatus.create! id: 1, name: "pending"
OrderStatus.create! id: 2, name: "processing"
OrderStatus.create! id: 3, name: "failed"
OrderStatus.create! id: 4, name: "succeed"
