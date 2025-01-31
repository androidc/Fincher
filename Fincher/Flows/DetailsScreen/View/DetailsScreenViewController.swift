import UIKit

final class DetailsScreenViewController: UIViewController {
    enum Const: String {
        case cell = "DetailsScreenCell"
    }

    private let closeButton = UIButton()
    private let tableView = UITableView()
    var viewModel: DetailsScreenViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension DetailsScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel?.monthData.count ?? 0
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Const.cell.rawValue,
            for: indexPath as IndexPath) as? DetailsScreenCell,
              let item = viewModel?.monthData[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.configure(item)
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        120
    }
}

private extension DetailsScreenViewController {
    func setupView() {
        addTableView()
        setupCloseButton()
    }

    func addTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            DetailsScreenCell.self,
            forCellReuseIdentifier: Const.cell.rawValue)
        view.addSubview(tableView)
        setupTableViewConstraint()
    }

    func setupTableViewConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.backgroundColor = .systemBackground
        closeButton.setTitleColor(.label, for: .normal)
        closeButton.layer.cornerRadius = 8
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            closeButton.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }

    @objc
    func closeButtonTap() {
        dismiss(animated: true)
    }
}
