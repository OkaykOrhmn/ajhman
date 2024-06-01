enum CommentBtnType {
  like('assets/icon/outline/like.svg','assets/icon/bold/like.svg'),
  disLike('assets/icon/outline/dislike.svg','assets/icon/bold/dislike.svg'),
  reply('assets/icon/outline/reply.svg','');

  const CommentBtnType(this.icon,this.fill);

  final String icon;
  final String fill;
}

enum CommentType{
  normal,
  owner,
  reply
}
