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
