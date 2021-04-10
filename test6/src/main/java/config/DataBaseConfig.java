package config;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.io.DefaultVFS;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;



@Configuration
@EnableTransactionManagement
@MapperScan(annotationClass= Mapper.class, sqlSessionTemplateRef="apiSqlSessionTemplate", basePackages = {"config","board"})
@PropertySource( "classpath:/config-local.properties" )
public class DataBaseConfig {
	
	
	@Value(value="${jdbc.driver}") private String jdbc_driver;
	@Value(value="${jdbc.url}") private String jdbc_url;
	@Value(value="${jdbc.username}") private String jdbc_username;
	@Value(value="${jdbc.password}") private String jdbc_password;

    @Bean
    public DataSource dataSource() {
        BasicDataSource basicDataSource = new BasicDataSource();
        basicDataSource.setDriverClassName(this.jdbc_driver);
        basicDataSource.setUrl( this.jdbc_url);
        basicDataSource.setUsername( this.jdbc_username);
        basicDataSource.setPassword(this.jdbc_password);
        basicDataSource.setDefaultAutoCommit(false);  
        return basicDataSource;
    }
    
	@Bean(name = "apiSqlSessionTemplate")
    public SqlSessionTemplate apiSqlSessionTemplateLocal( @Qualifier("dataSource") DataSource dataSource ) throws Exception {

		/** SESSION FACTORY 생성 **/
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource( dataSource );
		PathMatchingResourcePatternResolver pmrpr = new PathMatchingResourcePatternResolver();
		sqlSessionFactoryBean.setConfigLocation( pmrpr.getResource("classpath:/mybatis-config.xml") );
		sqlSessionFactoryBean.setMapperLocations( pmrpr.getResources( "classpath:mappers/**/*Mapper.xml" ) );
	    sqlSessionFactoryBean.setVfs( DefaultVFS.class );

	    sqlSessionFactoryBean.afterPropertiesSet();
	    return new SqlSessionTemplate( sqlSessionFactoryBean.getObject() );

	}

    @Bean
    public PlatformTransactionManager transactionManager() {
        DataSourceTransactionManager dataSourceTransactionManager = new DataSourceTransactionManager();
        dataSourceTransactionManager.setDataSource(dataSource());
        return dataSourceTransactionManager;
    }
}