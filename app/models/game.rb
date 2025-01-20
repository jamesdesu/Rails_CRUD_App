class Game < ApplicationRecord
    def self.publisherSearch(publisher)
        if publisher
            where(publisher: publisher)
        else
            all
        end
    end

    def self.releaseYearSearch(releaseYear)
        if releaseYear
            where(releaseYear: releaseYear)
        else
            all
        end
    end

    def self.titleSearch(title)
        if title
            where(title: title)
        else
            all
        end
    end

    def self.systemSearch(system)
        if system
            where(system: system)
        else
            all
        end
    end
end
