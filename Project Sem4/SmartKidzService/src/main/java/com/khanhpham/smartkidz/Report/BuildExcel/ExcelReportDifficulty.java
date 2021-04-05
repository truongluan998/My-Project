package com.khanhpham.smartkidz.Report.BuildExcel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.khanhpham.smartkidz.dto.DifficultiesDto;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

public class ExcelReportDifficulty extends AbstractXlsView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        response.setHeader("Content-Disposition", "attachment;filename=\"difficulty.xls\"");
        List<DifficultiesDto> diffList = (List<DifficultiesDto>) model.get("diffList");
        Sheet sheet = workbook.createSheet("Difficulties data");
        Row header = sheet.createRow(0);

        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("Game");
        header.createCell(2).setCellValue("Name");
        header.createCell(3).setCellValue("Required Score");
        header.createCell(4).setCellValue("Time Limit");
        header.createCell(5).setCellValue("Total Time Play");
        header.createCell(6).setCellValue("Total Question");
        header.createCell(7).setCellValue("Active");

        int rowNum = 1;
        for (DifficultiesDto dl : diffList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(dl.getId());
            row.createCell(1).setCellValue(dl.getGameId().getName());
            row.createCell(2).setCellValue(dl.getName());
            row.createCell(3).setCellValue(dl.getRequiredScore());
            row.createCell(4).setCellValue(dl.getTimeLimit());
            row.createCell(5).setCellValue(dl.getTotalTimePlay());
            row.createCell(6).setCellValue(dl.getTotalQuestion());
            row.createCell(7).setCellValue(dl.getIsActive().toString());
        }

    }

}
