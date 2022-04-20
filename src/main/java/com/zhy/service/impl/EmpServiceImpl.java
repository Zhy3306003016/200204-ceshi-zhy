package com.zhy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zhy.entity.Emp;
import com.zhy.mapper.EmpMapper;
import com.zhy.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmpServiceImpl implements EmpService {
    @Autowired
    private EmpMapper empMapper;
    @Override
    public Page<Emp> getAllEmp(Integer page, Integer limit, String name) {
        Page<Emp> empIPage = new Page<>();
        empIPage.setCurrent(page);
        empIPage.setSize(limit);
        QueryWrapper<Emp> empQueryWrapper = new QueryWrapper<>();
        if (name != null) {
            empQueryWrapper.like("name",name);
        }
        return empMapper.selectPage(empIPage,empQueryWrapper);
    }

    @Override
    public Emp addEmp(Emp emp) {
        int len = empMapper.insert(emp);
        if (len == 0) {
            throw new RuntimeException("错误");
        }
        return emp;
    }

    @Override
    public Emp updateEmp(Emp emp) {
        int len = empMapper.updateById(emp);
        if (len == 0) {
            throw new RuntimeException("错误");
        }
        return emp;
    }

    @Override
    public void delEmp(long id) {
        empMapper.deleteById(id);
    }
}
