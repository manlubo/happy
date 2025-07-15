package com.gitbaby.happygivers.mapper.hanler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;


import com.gitbaby.happygivers.domain.en.Ctype;

@MappedTypes(Ctype.class)
@MappedJdbcTypes(JdbcType.VARCHAR)
public class CtypeHandler extends BaseTypeHandler<Ctype>{

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, Ctype parameter, JdbcType jdbcType)
			throws SQLException {
		ps.setString(i, parameter.name());
		
	}

	@Override
	public Ctype getNullableResult(ResultSet rs, String columnName) throws SQLException {
		return Ctype.valueOf(rs.getString(columnName));
	}

	@Override
	public Ctype getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		return Ctype.valueOf(rs.getString(columnIndex));
	}

	@Override
	public Ctype getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		return Ctype.valueOf(cs.getString(columnIndex));
	}
	
}
