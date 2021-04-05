package com.khanhpham.smartkidz.Report.BuildExcel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.khanhpham.smartkidz.dto.IconDto;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

public class ExcelReportIcon extends AbstractXlsView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        response.setHeader("Content-Disposition", "attachment;filename=\"icon.xls\"");
        List<IconDto> iconList = (List<IconDto>) model.get("iconList");
        Sheet sheet = workbook.createSheet("Admin data");
        Row header = sheet.createRow(0);

        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("URL");
        header.createCell(2).setCellValue("Active");

        int rowNum = 1;
        for (IconDto il : iconList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(il.getId());
            row.createCell(1).setCellValue(il.getUrl());
            row.createCell(2).setCellValue(il.getIsActive().toString());

        }

    }

}
