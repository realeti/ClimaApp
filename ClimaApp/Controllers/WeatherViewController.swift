//
//  WeatherViewController.swift
//  ClimaApp
//
//  Created by Apple M1 on 27.05.2024.
//

import UIKit
import SnapKit
import CoreLocation

class WeatherViewController: UIViewController {
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: Constants.background)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var geoButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setBackgroundImage(UIImage(systemName: Constants.geoSF), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(locationPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = Constants.search
        textField.borderStyle = .roundedRect
        textField.textAlignment = .right
        textField.textColor = .label
        textField.tintColor = .label
        textField.backgroundColor = .systemFill
        textField.font = .systemFont(ofSize: 25.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setBackgroundImage(UIImage(systemName: Constants.searchSF), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var conditionalImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: Constants.conditionSF)
        imageView.tintColor = UIColor(named: Constants.weatherColor)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 80.0, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var tempTypeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 100.0, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Private Properties
    private var weatherManager = WeatherManager()
    private var locationManager = CLLocationManager()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setDelegates()
        setupConstraints()
        setupLocationSettings()
    }
    
    // MARK: - Private Methods
    
    private func setDelegates() {
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
    }
    
    private func setupLocationSettings() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    // MARK: - Actions
    
    @objc func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    @objc func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    // MARK: - Setup Views
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(headerStackView)
        
        headerStackView.addArrangedSubview(geoButton)
        headerStackView.addArrangedSubview(searchTextField)
        headerStackView.addArrangedSubview(searchButton)
        
        mainStackView.addArrangedSubview(conditionalImageView)
        mainStackView.addArrangedSubview(tempStackView)
        
        tempStackView.addArrangedSubview(tempLabel)
        tempStackView.addArrangedSubview(tempTypeLabel)
        
        mainStackView.addArrangedSubview(cityLabel)
        mainStackView.addArrangedSubview(emptyView)
    }
}

extension WeatherViewController {
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        setupBackgroundImageViewConstraints()
        setupMainStackViewConstraints()
        setupHeaderStackViewConstraints()
        setupHeaderButtonsConstraints()
        setupConditionImageViewConstraints()
    }
    
    private func setupBackgroundImageViewConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        /*NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])*/
    }
    
    private func setupMainStackViewConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        /*NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])*/
    }
    
    private func setupHeaderStackViewConstraints() {
        headerStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        /*NSLayoutConstraint.activate([
            headerStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])*/
    }
    
    private func setupHeaderButtonsConstraints() {
        geoButton.snp.makeConstraints { make in
            make.width.height.equalTo(40.0)
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.height.equalTo(40.0)
        }
        
        /*NSLayoutConstraint.activate([
            geoButton.widthAnchor.constraint(equalToConstant: 40.0),
            geoButton.heightAnchor.constraint(equalToConstant: 40.0),
            
            searchButton.widthAnchor.constraint(equalToConstant: 40.0),
            searchButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])*/
    }
    
    private func setupConditionImageViewConstraints() {
        conditionalImageView.snp.makeConstraints { make in
            make.width.height.equalTo(120.0)
        }
        
        /*NSLayoutConstraint.activate([
            conditionalImageView.widthAnchor.constraint(equalToConstant: 120.0),
            conditionalImageView.heightAnchor.constraint(equalToConstant: 120.0),
        ])*/
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // if pressed return key on the keyboard
        searchTextField.endEditing(true)
        searchTextField.text = ""
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text ?? "" != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { // if the pressed search button after editing text
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionalImageView.image = UIImage(systemName: weather.conditionName)
            self.tempLabel.text = weather.temperatureString
            self.tempTypeLabel.text = Constants.celsius
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
