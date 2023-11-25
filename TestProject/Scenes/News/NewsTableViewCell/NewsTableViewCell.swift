//
//  NewsTableViewCell.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import UIKit
//import Kingfisher

final class NewsTableViewCell: UITableViewCell {
    #warning("Make sure it is the right ViewCell")
    
    // MARK: - UI Elements
    private var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        #warning("Since all of them are in a stack, we don't need translate.. = false")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 117).isActive = true
        return imageView
    }()

    private var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3//0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private var newsAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newsTitleLabel, newsAuthorLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newsImageView, textStackView])
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupSubviews() {
        contentView.addSubview(mainStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.leftAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -20)
        ])
    }

    // MARK: - Configure
    func configure(with news: News) {
        let url = URL(string: news.urlToImage ?? "")
        //newsImageView.kf.setImage(with: url)
        newsTitleLabel.text = news.title
        newsAuthorLabel.text = news.authors
    }
}


