package com.zhy.controller;

import com.zhy.entity.Emp;
import com.zhy.entity.R;
import com.zhy.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class EmpController {
    @Autowired
    private EmpService empService;

    /**
     * 多条件分页查
     * @param page
     * @param limit
     * @param name
     * @return
     */
    @GetMapping("/emps")
    public R getAllEmp(@RequestParam("page") Integer page,@RequestParam("limit") Integer limit,String name){
        return R.ok().put("map",empService.getAllEmp(page,limit,name));
    }

    /**
     * 增加
     * @param emp
     * @return
     */
    @PostMapping("/emps")
    public R addEmp(Emp emp){
        return R.ok().put("map",empService.addEmp(emp));
    }

    /**
     * 修改
     * @param emp
     * @return
     */
    @PutMapping("/emps")
    public R updateEmp(Emp emp){
        return R.ok().put("map",empService.updateEmp(emp));
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @DeleteMapping("/emps")
    public R delEmp(long id){
        empService.delEmp(id);
        return R.ok();
    }
}
