
https://segmentfault.com/a/1190000024515231

1. MySQL表的列数限制
1.1 MySQL硬性限制每个表最大4096个列
1.2 InnoDB存储引擎的约束: 每个表最大1017个列;

2. MySQL表的每行数据的限制
2.1 MySQL表限制row size最大 65535个字节
2.2 InnoDB限制row size最大半页, 默认页大小16K, 也就是 row size < 8K;

3. MySQL表总数据量的限制
3.1 一个表的总大小限制取决于操作系统的文件限制
1) windows fat32的话, 最大就是4G
如果要想超过4G, 在64位windows上使用NTFS ;
2) 其他的windows上的文件数的限制等
在Windows上，表空间文件的路径(包括文件名)不能超过MAX_PATH限制。
在Windows 10之前，MAX_PATH的限制是260个字符。从Windows 10 1607版本开始，常见的Win32文件和目录函数中删除了MAX_PATH限制，但是必须启用新的行为。

3.2 默认MyISAM数据和索引文件最大到256TB，但此限制可改为最大65536TB
3.3 InnoDB的表大小限制:64T(取决于页大小, 详见下5)


4. MySQL数据库的表个数:无限制(InnoDB允许40亿个表)

- MySQL对表的数量没有限制。
- 底层文件系统可能对表示表的文件数量有限制。
- 单个存储引擎可能会施加特定于引擎的约束: InnoDB允许多达40亿个表

5. 综上-总结InnoDB的限制
5.1 MySQL5.6以后允许InnoDB表最多1017个列
5.2 一个InnoDB表最多允许64个二级索引
5.3 默认索引前缀长度最多767bytes
5.4 联合索引最多允许16个列, 多了报错
5.5 InnoDB的最大行大小为半页(小于8K-默认)
- 由于默认页大小为16K, 要求是小于half page size, 就是小于8K;
- innodb_page_size可以通过这个修改为4K, 8K; 这样的话, rowsize 就限制为小于 2K, 4K了;
- 虽然InnoDB内部支持大于65,535字节的行大小，但MySQL本身对所有列的合并大小施加了65,535的行大小限制。-?跨页?另设置?
5.6 innoDB日志文件的最大组合大小是512G
5.7 InnoDB表空间大小限制64T(表空间最大大小也是表的最大大小)
- 最小表空间大小略大于10MB
- 最大表空间大小取决于InnoDB的页面大小:

InnoDB Page Size	Maximum Tablespace Size
4KB	16TB
8KB	32TB
16KB	64TB
参考1: Limits on Table Column Count and Row Size

image.png

参考2: Limits on Table Size


## reference

- https://matthung0807.blogspot.com/2019/06/mysql-varcharmaximum-length.html
- https://dev.mysql.com/doc/refman/5.6/en/table-size-limit.html