package com.khanhpham.smartkidz.Report.BuildExcel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.khanhpham.smartkidz.dto.GamesDto;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsView;

public class ExcelReportGame extends AbstractXlsView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        response.setHeader("Content-Disposition", "attachment;filename=\"games.xls\"");
        List<GamesDto> gameList = (List<GamesDto>) model.get("gameList");
        Sheet sheet = workbook.createSheet("Games data");
        Row header = sheet.createRow(0);

        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("Image");
        header.createCell(2).setCellValue("Name");
        header.createCell(3).setCellValue("Description");
        header.createCell(4).setCellValue("Background Music");
        header.createCell(5).setCellValue("Active");

        int rowNum = 1;
        for (GamesDto gl : gameList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(gl.getId());
            row.createCell(1).setCellValue(gl.getImage());
            row.createCell(2).setCellValue(gl.getName());
            row.createCell(3).setCellValue(gl.getDescription());
            row.createCell(4).setCellValue(gl.getBgm());
            row.createCell(5).setCellValue(gl.getIsActive().toString());
        }

    }

}
