package com.candao.irms.registry;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * DMS服务注册中心
 * 
 * @author jeromeLiu
 * @version 1.0.0 2017年4月19日 下午3:32:26
 */
@EnableEurekaServer
@SpringBootApplication
public class ServiceRegistryCenterApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServiceRegistryCenterApplication.class, args);
	}

}
