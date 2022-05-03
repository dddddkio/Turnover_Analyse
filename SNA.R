data <- read_excel("data.xlsx", 1)[3:4]
# 重命名表头 from & to
colnames(data) <- c("from", "to")
# 删除包含空值的行
data1 <- na.omit(data)
# 删除起始地和终点相同的行
data2 <- data1[which(data1$from != data1$to),]
# 分类排序
data3 = data2 %>%
  group_by(from) 
# 定义排序规则 第一优先from 第二优先to
o <- order(data3[,"from"],data3[,"to"])
# 应用排序规则
data4 = data3[o,]
# 计算重复次数 定义 sum 列存放
data5 = aggregate(list(sum=rep(1,nrow(data4))), data4, length)
# 生成图表
p <- ggplot(data5, aes(x=from,y=to)) 
# 以 sum 值为填充标准
p <- p + geom_tile(aes(fill=sum)) 
# 旋转 x 轴标签
p <- p + theme(axis.text.x=element_text(angle=90,hjust=1, vjust=1))
# 展示图表
p