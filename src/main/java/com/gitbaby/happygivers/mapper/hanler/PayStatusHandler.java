package com.gitbaby.happygivers.mapper.hanler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;


import com.gitbaby.happygivers.domain.en.PayStatus;

@MappedTypes(PayStatus.class)
@MappedJdbcTypes(JdbcType.VARCHAR)
public class PayStatusHandler extends BaseTypeHandler<PayStatus>{

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, PayStatus parameter, JdbcType jdbcType)
			throws SQLException {
		ps.setString(i, parameter.name());
		
	}

	@Override
	public PayStatus getNullableResult(ResultSet rs, String columnName) throws SQLException {
		return PayStatus.valueOf(rs.getString(columnName));
	}

	@Override
	public PayStatus getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		return PayStatus.valueOf(rs.getString(columnIndex));
	}

	@Override
	public PayStatus getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		return PayStatus.valueOf(cs.getString(columnIndex));
	}
	
}
