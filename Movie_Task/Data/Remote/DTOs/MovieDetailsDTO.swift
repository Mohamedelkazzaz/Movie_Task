//
//  MovieDetailsDTO.swift
//  Movie_Task
//
//  Created by Mohamed Elkazzaz on 15/07/2025.
//

import Foundation

struct MovieDetailsDTO: Codable {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: BelongsToCollectionDTO?
    let budget: Int
    let genres: [GenreDTO]
    let homepage: String
    let id: Int
    let imdbID: String
    let originCountry: [String]
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompanyDTO]
    let productionCountries: [ProductionCountryDTO]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguageDTO]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult, budget, genres, homepage, id, overview, popularity, revenue, runtime, status, tagline, title, video, voteAverage = "vote_average", voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case spokenLanguages = "spoken_languages"
    }

    func toDomain() -> MovieDetails {
        return MovieDetails(
            adult: adult,
            backdropPath: backdropPath,
            belongsToCollection: belongsToCollection?.toDomain() ?? BelongsToCollection(id: 0, name: "", posterPath: "", backdropPath: ""),
            budget: budget,
            genres: genres.map { $0.toDomain() },
            homepage: homepage,
            id: id,
            imdbID: imdbID,
            originCountry: originCountry,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            productionCompanies: productionCompanies.map { $0.toDomain() },
            productionCountries: productionCountries.map { $0.toDomain() },
            releaseDate: releaseDate,
            revenue: revenue,
            runtime: runtime,
            spokenLanguages: spokenLanguages.map { $0.toDomain() },
            status: status,
            tagline: tagline,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount
        )
    }
}

struct BelongsToCollectionDTO: Codable {
    let id: Int
    let name: String
    let posterPath: String
    let backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }

    func toDomain() -> BelongsToCollection {
        return BelongsToCollection(id: id, name: name, posterPath: posterPath, backdropPath: backdropPath)
    }
}

struct GenreDTO: Codable {
    let id: Int
    let name: String

    func toDomain() -> Genre {
        return Genre(id: id, name: name)
    }
}

struct ProductionCompanyDTO: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }

    func toDomain() -> ProductionCompany {
        return ProductionCompany(id: id, logoPath: logoPath, name: name, originCountry: originCountry)
    }
}

struct ProductionCountryDTO: Codable {
    let iso3166_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }

    func toDomain() -> ProductionCountry {
        return ProductionCountry(iso3166_1: iso3166_1, name: name)
    }
}

struct SpokenLanguageDTO: Codable {
    let englishName: String
    let iso639_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }

    func toDomain() -> SpokenLanguage {
        return SpokenLanguage(englishName: englishName, iso639_1: iso639_1, name: name)
    }
}
