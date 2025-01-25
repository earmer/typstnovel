#import "template/typnovel.typ": chapter

#show: doc => chapter(
  title: "The First Chapter",
  chapternum: 1,
  volume: "The First Volume",
  volumenum: 1,
  date: datetime.today(),
  doc,
)

First and the last.

