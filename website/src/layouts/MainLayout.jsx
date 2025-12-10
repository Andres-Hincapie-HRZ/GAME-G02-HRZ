import Footer from "../components/footer";

export default function MainLayout({
    children
}) {

    return (
        <div>
            { children }
            <div className="px-3">
                <footer className="foot mt-5 p-3">
                    <Footer />
                </footer>
            </div>
        </div>
    )

}