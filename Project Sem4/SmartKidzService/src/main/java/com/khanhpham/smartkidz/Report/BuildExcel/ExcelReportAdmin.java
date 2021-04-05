package com.khanhpham.smartkidz.Report.BuildExcel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.khanhpham.smartkidz.dto.UsersDto;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

public class ExcelReportAdmin extends AbstractXlsView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        response.setHeader("Content-Disposition", "attachment;filename=\"admin.xls\"");
        List<UsersDto> adminList = (List<UsersDto>) model.get("adminList");
        Sheet sheet = workbook.createSheet("Admin data");
        Row header = sheet.createRow(0);

        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("Photo");
        header.createCell(2).setCellValue("Username");
        header.createCell(3).setCellValue("Full Name");
        header.createCell(4).setCellValue("Email");
        header.createCell(5).setCellValue("Gender");
        header.createCell(6).setCellValue("Active");

        int rowNum = 1;
        for (UsersDto al : adminList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(al.getId());
            row.createCell(1).setCellValue(al.getPhoto());
            row.createCell(2).setCellValue(al.getUsername());
            row.createCell(3).setCellValue(al.getFullName());
            row.createCell(4).setCellValue(al.getEmail());
            row.createCell(5).setCellValue(al.getGender().toString());
            row.createCell(6).setCellValue(al.getIsActive().toString());
        }
    }

}
