package com.khanhpham.smartkidz.Report.BuildExcel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.khanhpham.smartkidz.dto.LevelsDto;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

public class ExcelRepotLevel extends AbstractXlsView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        response.setHeader("Content-Disposition", "attachment;filename=\"levels.xls\"");
        List<LevelsDto> lvList = (List<LevelsDto>) model.get("lvList");
        Sheet sheet = workbook.createSheet("History data");
        Row header = sheet.createRow(0);

        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("Icon");
        header.createCell(2).setCellValue("Name");
        header.createCell(3).setCellValue("Required Level Score");
        header.createCell(4).setCellValue("Active");

        int rowNum = 1;
        for (LevelsDto lv : lvList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(lv.getId());
            row.createCell(1).setCellValue(lv.getIcon());
            row.createCell(2).setCellValue(lv.getName());
            row.createCell(3).setCellValue(lv.getRequiredLevelScore());
            row.createCell(4).setCellValue(lv.getIsActive().toString());
        }

    }

}
