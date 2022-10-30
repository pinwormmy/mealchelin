package kh.project4.mealchelin;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan(value={"kh.project4.mealchelin.mapper"})
@SpringBootApplication
public class MealchelinApplication {
	public static void main(String[] args) {
		SpringApplication.run(MealchelinApplication.class, args);
	}

}

// 깃이그노어 작동 다시 확인. 로컬에서도 로컬 디비로 실행할 수 있게 세팅하기