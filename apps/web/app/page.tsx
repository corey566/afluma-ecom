const decisions = [
  'One shared and versioned source codebase',
  'One verified domain per tenant',
  'One logical PostgreSQL database per tenant',
  'Shared application cells with enterprise isolation options',
  'Store Edge for offline multi-cashier operation',
];

export default function FoundationPage() {
  return <main>
    <section className="hero">
      <p className="eyebrow">Afluma Commerce · Foundation</p>
      <h1>Commerce infrastructure we can safely build on.</h1>
      <p className="lead">The first milestone proves an offline sale across two cashiers, exact-once synchronization, inventory integrity and balanced accounting.</p>
      <div className="grid">{decisions.map((item) => <article key={item}>{item}</article>)}</div>
    </section>
  </main>;
}
