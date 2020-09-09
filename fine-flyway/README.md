# Flyway
> flyway是一款轻量的数据库版本控制工具. 
在日常的研发过程中, 修改数据库的操作经常有, 但是开发库和测试库的同步也是一件麻烦的事, 
需要手工执行sql, 对于sql的管理有时候也有心无力。
可能sql没执行，导致服务不可用的情况。
建议flyway还是仅在开发和测试环境使用, 生产的sql执行还是人工执行更保险.

## Flyway使用

### springboot集成flyway
flyway的执行流程: 项目集成flyway启动后，会在数据库建一张flyway_schema_history的表，根据每次执行，记录执行版本情况

- 添加依赖
> 
    <dependency>
        <groupId>org.flywaydb</groupId>
        <artifactId>flyway-core</artifactId>
        <version>5.2.4</version>
    </dependency>
    
- application.properties配置
>
    # 根据生产配置
    #flyway.enable = false
    spring.flyway.enabled=${flyway.enable}
    spring.flyway.clean-disabled=true
    spring.flyway.baseline-on-migrate=true
    spring.flyway.baseline-version=0
    spring.flyway.locations=classpath:db/migration

- sql管理
    - sql命名
    > 以V开头后面跟数字和两个下划线, 例V1__CREATE_TABLE_XXX.SQL
    - sql脚本管理
    > 每次修改sql都单独建个sql文件
    