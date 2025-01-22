class Game < ApplicationRecord
    #Method to search based on publisher, but only if the requested search references a publisher.
    def self.publisherSearch(publisher)
        if publisher
            where(publisher: publisher)
        else
            all
        end
    end

    #Method to search based on release year, but only if the requested search references a release year.
    def self.releaseYearSearch(releaseYear)
        if releaseYear
            where(releaseYear: releaseYear)
        else
            all
        end
    end

    #Method to search based on title, but only if the requested search references a title.
    def self.titleSearch(title)
        if title
            where(title: title)
        else
            all
        end
    end

    #Method to search based on system, but only if the requested search references a system.
    def self.systemSearch(system)
        if system
            where(system: system)
        else
            all
        end
    end
end
