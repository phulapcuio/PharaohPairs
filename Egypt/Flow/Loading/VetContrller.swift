//
//  VebContrller.swift
//  Egypt
//
//  Created by Dmitriy Holovnia on 22.03.2024.
//

import UIKit
import WebKit

final class VetContrller: UIViewController {
    let url: URL

    lazy private var webV: WKWebView = {
        let webview = WKWebView()
        webview.autoresizingMask = .flexibleWidth
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()
    private lazy var backButton: UIBarButtonItem = {
        let image = UIImage(systemName: "backward.fill")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backTapped))
        return button
    }()
    private lazy var refreshButton: UIBarButtonItem = {
        let image = UIImage(systemName: "arrow.triangle.2.circlepath")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(refreshTapped))
        return button
    }()
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.backgroundColor = .white
        toolbar.tintColor = #colorLiteral(red: 0, green: 0.46, blue: 0.89, alpha: 1)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [backButton, spacer, refreshButton]
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()


    lazy private var activityIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.frame = CGRect(x: view.frame.midX-20, y: view.frame.midY-20, width: 40, height: 40)
        v.tintColor = .blue
        v.hidesWhenStopped = true
        v.startAnimating()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    init(liq: URL) {
        self.url = liq
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented", file: "")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        webV.navigationDelegate = self
        setupUI()
        setupWv()
    }

    // MARK: - UI Action

    @objc private func backTapped(_ sender: UIBarButtonItem) {
        if webV.canGoBack {
            webV.goBack()
        }
    }

    @objc private func refreshTapped(_ sender: UIBarButtonItem) {
        webV.reload()
    }

    private func setupUI() {
        view.addSubview(webV)
        NSLayoutConstraint.activate([
            webV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webV.topAnchor.constraint(equalTo: view.topAnchor),
            webV.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        view.addSubview(toolbar)
        NSLayoutConstraint.activate([
            toolbar.widthAnchor.constraint(equalTo: view.widthAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 40),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupSwipeBack() {
        let rightSwipe =  UISwipeGestureRecognizer(target: webV,
                                                   action: #selector(webV.goBack))
        rightSwipe.direction = .right
        webV.addGestureRecognizer(rightSwipe)
    }

    private func setupWv() {
        startWv(for: url)
    }

    private func startWv(for url: URL) {
        setupSwipeBack()
        let rightSwipe =  UISwipeGestureRecognizer(target: webV, action: #selector(webV.goBack))
        rightSwipe.direction = .right
        webV.addGestureRecognizer(rightSwipe)

        let request = URLRequest(url: url)
        webV.load(request)
    }
}

// MARK: - WKNavigationDelegate

extension VetContrller: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url {
            UserMemory.shared.link = url.absoluteString
        }
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        if navigationAction.navigationType == .linkActivated {
            guard let url = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }

            webView.load(URLRequest(url: url))

            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

