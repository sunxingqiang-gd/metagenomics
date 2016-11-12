## 宏基因组分析流程调研和设计

### 分析流程主要的内容为：

1. 测序数据过滤和质控
2. 去除宿主序列（一般适用于人相关宏基因组或其他已知宿主参考基因组）
3. reads数据库比对和物种分类
#4. 基因组预测
#5. 多样性分析

参考流程为[mocat2](http://mocat.embl.de/index.html)
参考流程图为![meta_pipeline](http://mocat.embl.de/images/supplfig.png)

### 重要技术点和难点
1. 过滤软件的选择
一般的操作没问题，在去reads dup的时候有的软件比如prinseq会将reads全部读入到内存导致10G左右的数据会需求50-60G左右的内存。
按照以往的经验，即使去dup内存也差不多在2G左右，所以需要选择合适的过滤软件。
fastx或者SolexaQA

2. 去除宿主序列
这部分内容可以进行选择性的做，对于人相关metagenomics，宿主参考基因组选择人的参考序列即可。
可能涉及到的软件 bwa/soap（短reads比对）和 unmaped reads保留

3. reads数据库比对
选择合适的数据库，核酸数据库选择nt。为了减少计算量，通过tax_id等文件将属于微生物（细菌，真菌，古菌，病毒，质粒）的nt序列提取。
选择合适的比对工具 bwa/soap
选择合适的注释工具 megan

