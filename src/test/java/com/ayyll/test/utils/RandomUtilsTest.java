package com.ayyll.test.utils;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.ayyll.dbutil.RandomUtils;

public class RandomUtilsTest {
	
	@Ignore
	public void testRandomNumber() {
		for(int i = 0; i < 10000; i++)
		System.out.println(RandomUtils.createRandomNumber(10));
	}
	@Test
	public void testRandomName() {
		for(int i = 0; i < 100000; i++) {
			System.out.println(RandomUtils.createRandomName());
		}
	}
}
