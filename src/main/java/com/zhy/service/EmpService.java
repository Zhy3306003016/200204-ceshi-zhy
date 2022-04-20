package com.zhy.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zhy.entity.Emp;

public interface EmpService {
    /**
     * 多条件分页查询
     * @param page
     * @param limit
     * @param name
     * @return
     */
    Page<Emp> getAllEmp(Integer page, Integer limit, String name);

    /**
     * 增加
     * @param emp
     * @return
     */
    Emp addEmp(Emp emp);

    /**
     * 修改
     * @param emp
     * @return
     */
    Emp updateEmp(Emp emp);

    /**
     * 删除
     * @param id
     */
    void delEmp(long id);
}
