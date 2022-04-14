package com.yoon.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yoon.mapper.TimeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:C:\\yoonweb\\src\\main\\resources\\spring\\rootContext.xml")
public class TimeMapperTests {

    @Autowired
    private TimeMapper timeMapper;

    @Test
    public void testGetTime() {
        System.out.println(timeMapper.getTime1());
    }

    @Test
    public void testGetTime2() {
        System.out.println(timeMapper.getTime2());
    }


}