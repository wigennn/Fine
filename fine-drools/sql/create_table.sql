CREATE TABLE `rule_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键规则id',
  `scanId` bigint(20) NOT NULL COMMENT '场景id',
  `rule_detail` LONGTEXT NOT NULL COMMENT '规则详情',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='规则表';