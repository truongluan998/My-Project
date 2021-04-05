package com.khanhpham.smartkidz.Report.BuildExcel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.khanhpham.smartkidz.dto.GamesDetailDto;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

public class ExcelReportGameDetail extends AbstractXlsView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        response.setHeader("Content-Disposition", "attachment;filename=\"gameDetails.xls\"");
        List<GamesDetailDto> gameDetailsList = (List<GamesDetailDto>) model.get("gameDetailsList");
        Sheet sheet = workbook.createSheet("GameDetails data");
        Row header = sheet.createRow(0);

        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("Question");
        header.createCell(2).setCellValue("Image");
        header.createCell(3).setCellValue("Correct Answer");
        header.createCell(4).setCellValue("Difficulty");
        header.createCell(5).setCellValue("Active");

        int rowNum = 1;
        for (GamesDetailDto gdl : gameDetailsList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(gdl.getId());
            row.createCell(1).setCellValue(gdl.getQuestion());
            row.createCell(2).setCellValue(gdl.getImage());
            row.createCell(3).setCellValue(gdl.getCorrectAnswer());
            row.createCell(4).setCellValue(gdl.getDifficultyId());
            row.createCell(5).setCellValue(gdl.getIsActive().toString());
        }

    }

}
