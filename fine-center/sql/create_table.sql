drop table if exists `user`;
create table `user`(
  `id` bigint(20) not null AUTO_INCREMENT comment '主键id',
  `user_name` varchar(20) not null comment '用户名',
  `phone` varchar(11) not null comment '手机号',
  `password` varchar(120) not null comment '密码',
  `name` varchar(50) not null comment '用户姓名',
  `role_id` tinyint(2) default 1 comment '角色id',
  `status` tinyint(2) default 0 comment '用户状态 0-正常 1-删除 2-拉黑',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=UTF8 COMMENT='用户表';

drop table if exists `role`;
create table `role`(
  `id` bigint(20) not null AUTO_INCREMENT comment '主键id',
  `role_name` varchar(20) not null comment '角色名',
  `status` tinyint(2) default 0 comment '用户状态 0-正常 1-删除',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=UTF8 COMMENT='角色表';

alter table user add unique key `unique_idx_user`(`user_name`,`phone`);