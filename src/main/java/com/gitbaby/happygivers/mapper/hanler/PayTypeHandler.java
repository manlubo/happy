package com.gitbaby.happygivers.mapper.hanler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;


import com.gitbaby.happygivers.domain.en.PayType;

@MappedTypes(PayType.class)
@MappedJdbcTypes(JdbcType.VARCHAR)
public class PayTypeHandler extends BaseTypeHandler<PayType>{

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, PayType parameter, JdbcType jdbcType)
			throws SQLException {
		ps.setString(i, parameter.name());
		
	}

	@Override
	public PayType getNullableResult(ResultSet rs, String columnName) throws SQLException {
		return PayType.valueOf(rs.getString(columnName));
	}

	@Override
	public PayType getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		return PayType.valueOf(rs.getString(columnIndex));
	}

	@Override
	public PayType getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		return PayType.valueOf(cs.getString(columnIndex));
	}
	
}
