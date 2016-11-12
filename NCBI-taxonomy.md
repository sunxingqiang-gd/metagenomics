## 关于ncbi taxonomy的总结

### 1 ndoes.dmp

files 内容如下：
- tax_id 在GenBank taxonomy数据库的 节点id
- parent tax_id 在taxonomy的父节点 id
- rank  该节点的分类等级是？比如superkingdom，kingdom，phlyum
- embl code  locus的名字
- division id  参见 division.dmp文件
- genetic code id 见 gencode.dmp文件


### 2 names.dmp
- tax_id 在GenBank taxonomy数据库的 节点id
- name_txt 序列的名称信息
- unique name 名字的变称

### 3 division.dmp
- division id taxonomy数据库的division id
- division cde genbank division code（三个字符简称）
- division name 比如BCT PLN RT MAM PRI等

### 4 gencode.dmp
- genetic code id  GenBank遗传代码id
- abbreviation genetic code 名称简称
- name genetic code名称
- starts 遗传代码的起始密码子

### 5 delnodes.dmp
- tax_id 已经删除的 node id

### 6 merged.dmp 合并的node记录
- old_tax_id  已经被合并的node id
- new_tax_id  合并后的node id

### 7 citations.dmp 引文数据库





