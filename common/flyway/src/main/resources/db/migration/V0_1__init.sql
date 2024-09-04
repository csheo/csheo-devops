create table common_code (
    code_key      mediumint unsigned auto_increment comment '코드Key' primary key,
    upper_key     mediumint unsigned             default '0'   not null comment '상위 코드Key',
    depth         tinyint unsigned               default '1'   not null comment '계층 레벨',
    display_order tinyint unsigned               default '255' null comment '표시 순서',
    use_yn        char collate latin1_general_ci default 'Y'   not null comment '사용 여부',
    code_id       varchar(30) collate latin1_general_ci        not null comment '코드ID',
    code_desc     varchar(50)                                  not null comment '코드 설명'
) comment '공통 코드';

create table language (
    lang_cd   char(5) collate latin1_general_ci          not null comment '언어지역코드(5자리)' primary key,
    lang2_cd  char(2) collate latin1_general_ci          not null comment '언어코드(2자리)',
    lang3_cd  char(3) collate latin1_general_ci          not null comment '언어코드(3자리)',
    region_cd char(2) collate latin1_general_ci          not null comment '지역코드(2자리)',
    iso_nm    varchar(50)                    default ''  not null comment 'ISO 언어명',
    native_nm varchar(50)                    default ''  not null comment '네이티브 언어명',
    basic_yn  char collate latin1_general_ci default 'N' not null comment '기본언어 여부',
    use_yn    char collate latin1_general_ci default 'Y' not null comment '사용 여부',
    lang_desc varchar(50)                    default ''  not null comment '언어 설명'
) comment '언어';

create table multilingual_desc (
    desc_key      int unsigned auto_increment comment '설명Key' primary key,
    target_cc_key mediumint unsigned                not null,
    target_key    int unsigned                      not null comment '대상Key',
    desc_cc_key   mediumint unsigned                not null comment '설명구분 코드Key',
    lang_cd       char(5) collate latin1_general_ci not null comment '언어지역코드(5자리)',
    cont_cc_key   mediumint unsigned                not null comment '내용 구분 코드Key',
    short_cont    varchar(500)                      null comment '짧은 설명 내용',
    long_cont     text                              null comment '긴 설명 내용'
) comment '다국어 설명';