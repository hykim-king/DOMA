package com.acorn.doma.proj4j;

import org.locationtech.proj4j.CRSFactory;
import org.locationtech.proj4j.CoordinateReferenceSystem;
import org.locationtech.proj4j.CoordinateTransform;
import org.locationtech.proj4j.CoordinateTransformFactory;
import org.locationtech.proj4j.ProjCoordinate;

public class CoordinateConverter {
	private static final CRSFactory crsFactory = new CRSFactory();
    private static final CoordinateTransformFactory ctFactory = new CoordinateTransformFactory();

    // GRS80 좌표계와 EPSG:4326 좌표계 정의
    private static final CoordinateReferenceSystem epsg5181 = crsFactory.createFromName("EPSG:5181"); // GRS80 / TM (중부)
    private static final CoordinateReferenceSystem epsg5179 = crsFactory.createFromName("EPSG:5179"); // GRS80 / TM (중부)
    private static final CoordinateReferenceSystem epsg4326 = crsFactory.createFromName("EPSG:4326"); // WGS84

    private static final CoordinateTransform transform_5181 = ctFactory.createTransform(epsg5181, epsg4326);
    private static final CoordinateTransform transform_5179 = ctFactory.createTransform(epsg5179, epsg4326);
    public static ProjCoordinate convert81(double x, double y) {
        ProjCoordinate srcCoord = new ProjCoordinate(x, y);
        ProjCoordinate destCoord = new ProjCoordinate();

        try {
        	transform_5181.transform(srcCoord, destCoord);
        } catch (Exception e) {
            e.printStackTrace();
            // 변환 실패 시 기본 좌표 설정 또는 예외 처리
            destCoord = new ProjCoordinate();
        }

        return destCoord;
    }
    public static ProjCoordinate convert79(double x, double y) {
        ProjCoordinate srcCoord = new ProjCoordinate(x, y);
        ProjCoordinate destCoord = new ProjCoordinate();

        try {
        	transform_5179.transform(srcCoord, destCoord);
        } catch (Exception e) {
            e.printStackTrace();
            // 변환 실패 시 기본 좌표 설정 또는 예외 처리
            destCoord = new ProjCoordinate();
        }

        return destCoord;
    }
}