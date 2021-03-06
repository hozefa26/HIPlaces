//
//  HIPlaceTypes.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 30/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HIPlaceType) {
    HIPlaceTypeNone,
    HIPlaceTypeAccounting,
    HIPlaceTypeAirport,
    HIPlaceTypeAmusementPark,
    HIPlaceTypeAquarium,
    HIPlaceTypeArtGallery,
    HIPlaceTypeATM,
    HIPlaceTypeBakery,
    HIPlaceTypeBank,
    HIPlaceTypeBar,
    HIPlaceTypeBeautySalon,
    HIPlaceTypeBicycleStore,
    HIPlaceTypeBookStore,
    HIPlaceTypeBowlingAlley,
    HIPlaceTypeBusStation,
    HIPlaceTypeCafe,
    HIPlaceTypeCampground,
    HIPlaceTypeCarDealer,
    HIPlaceTypeCarRental,
    HIPlaceTypeCarRepair,
    HIPlaceTypeCarWash,
    HIPlaceTypeCasino,
    HIPlaceTypeCemetery,
    HIPlaceTypeChurch,
    HIPlaceTypeCityHall,
    HIPlaceTypeClothingStore,
    HIPlaceTypeConvenienceStore,
    HIPlaceTypeCourthouse,
    HIPlaceTypeDentist,
    HIPlaceTypeDepartmentStore,
    HIPlaceTypeDoctor,
    HIPlaceTypeElectrician,
    HIPlaceTypeElectronicsStore,
    HIPlaceTypeEmbassy,
    HIPlaceTypeEstablishment,
    HIPlaceTypeFinance,
    HIPlaceTypeFireStation,
    HIPlaceTypeFlorist,
    HIPlaceTypeFood,
    HIPlaceTypeFuneralHome,
    HIPlaceTypeFurnitureStore,
    HIPlaceTypeGasStation,
    HIPlaceTypeGeneralContractor,
    HIPlaceTypeGroceryOrSupermarkt,
    HIPlaceTypeGym,
    HIPlaceTypeHairCare,
    HIPlaceTypeHardwareStore,
    HIPlaceTypeHealth,
    HIPlaceTypeHinduTemple,
    HIPlaceTypeHomeGoodsStore,
    HIPlaceTypeHospital,
    HIPlaceTypeInsuranceAgency,
    HIPlaceTypeJewelryStore,
    HIPlaceTypeLaundry,
    HIPlaceTypeLawyer,
    HIPlaceTypeLibrary,
    HIPlaceTypeLiquorStore,
    HIPlaceTypeLocalGovermentOffice,
    HIPlaceTypeLocksmith,
    HIPlaceTypeLodging,
    HIPlaceTypeMealDelivery,
    HIPlaceTypeMealTakeaway,
    HIPlaceTypeMosque,
    HIPlaceTypeMovieRental,
    HIPlaceTypeMovieTheater,
    HIPlaceTypeMovingCompany,
    HIPlaceTypeMuseum,
    HIPlaceTypeNightClub,
    HIPlaceTypePainter,
    HIPlaceTypePark,
    HIPlaceTypeParking,
    HIPlaceTypePetStore,
    HIPlaceTypePharmacy,
    HIPlaceTypePhysiotherapist,
    HIPlaceTypePlaceOfWorship,
    HIPlaceTypePlumber,
    HIPlaceTypePolice,
    HIPlaceTypePostOffice,
    HIPlaceTypeRealEstateAgency,
    HIPlaceTypeRestaurant,
    HIPlaceTypeRoofingContractor,
    HIPlaceTypeRVPark,
    HIPlaceTypeSchool,
    HIPlaceTypeShoeStore,
    HIPlaceTypeShoppingMall,
    HIPlaceTypeSpa,
    HIPlaceTypeStadium,
    HIPlaceTypeStorage,
    HIPlaceTypeStore,
    HIPlaceTypeSubwayStation,
    HIPlaceTypeSynagogue,
    HIPlaceTypeTaxiStand,
    HIPlaceTypeTrainStation,
    HIPlaceTypeTravelAgency,
    HIPlaceTypeUniversity,
    HIPlaceTypeVeterinaryCare,
    HIPlaceTypeZoo,
    HIPlaceTypeAddress,
    HIPlaceTypeAdministrativeAreaLevel1,
    HIPlaceTypeAdministrativeAreaLevel2,
    HIPlaceTypeAdministrativeAreaLevel3,
    HIPlaceTypeAdministrativeAreaLevel4,
    HIPlaceTypeAdministrativeAreaLevel5,
    HIPlaceTypeColloquialArea,
    HIPlaceTypeCountry,
    HIPlaceTypeFloor,
    HIPlaceTypeGeocode,
    HIPlaceTypeIntersection,
    HIPlaceTypeLocality,
    HIPlaceTypeNaturalFeature,
    HIPlaceTypeNeighborhood,
    HIPlaceTypePolitical,
    HIPlaceTypePointOfInterest,
    HIPlaceTypePostBox,
    HIPlaceTypePostalCode,
    HIPlaceTypePostalCodePrefix,
    HIPlaceTypePostalCodeSuffix,
    HIPlaceTypePostalTown,
    HIPlaceTypePremise,
    HIPlaceTypeRoom,
    HIPlaceTypeRoute,
    HIPlaceTypeStreetAddress,
    HIPlaceTypeStreetNumber,
    HIPlaceTypeSublocality,
    HIPlaceTypeSublocalityLevel1,
    HIPlaceTypeSublocalityLevel2,
    HIPlaceTypeSublocalityLevel3,
    HIPlaceTypeSublocalityLevel4,
    HIPlaceTypeSublocalityLevel5,
    HIPlaceTypeSubpremise,
    HIPlaceTypeTransitStation,
    HIPlaceTypeRegionsCollection,
    HIPlaceTypeCitiesCollection
};

@interface HIPlaceTypes : NSObject

+ (NSString *)placeTypeStringForPlaceType:(HIPlaceType)placeType;
+ (NSArray *)placeTypeStringsForPlaceTypes:(NSArray *)placeTypes;
+ (HIPlaceType)placeTypeForPlaceTypeString:(NSString *)placeTypeString;
+ (NSArray *)placeTypesForPlaceTypeStrings:(NSArray *)placeTypeStrings;

@end
