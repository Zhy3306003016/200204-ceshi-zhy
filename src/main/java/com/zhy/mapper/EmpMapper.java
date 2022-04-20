package com.zhy.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zhy.entity.Emp;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmpMapper extends BaseMapper<Emp> {
}
