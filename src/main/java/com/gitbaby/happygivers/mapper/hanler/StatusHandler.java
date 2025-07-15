package com.gitbaby.happygivers.mapper.hanler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;


import com.gitbaby.happygivers.domain.en.Status;

@MappedTypes(Status.class)
@MappedJdbcTypes(JdbcType.VARCHAR)
public class StatusHandler extends BaseTypeHandler<Status>{

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, Status parameter, JdbcType jdbcType)
			throws SQLException {
		ps.setString(i, parameter.name());
		
	}

	@Override
	public Status getNullableResult(ResultSet rs, String columnName) throws SQLException {
		return Status.valueOf(rs.getString(columnName));
	}

	@Override
	public Status getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		return Status.valueOf(rs.getString(columnIndex));
	}

	@Override
	public Status getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		return Status.valueOf(cs.getString(columnIndex));
	}
	
}
