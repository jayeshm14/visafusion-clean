# 05_GraphRAG_and_MCP

## Purpose

Define deterministic use of GraphRAG and Model Context Protocol (MCP).

## GraphRAG Pipeline

Specifications → Parse → Knowledge Graph → Embeddings → Vector Index →
Retrieval → Reasoning → Verified Output

## Retrieval Priority

1.  Approved specifications
2.  ADRs
3.  Architecture
4.  Source code
5.  Tests
6.  Documentation

Never answer from embeddings alone when authoritative specifications
exist.

## MCP Usage

Use MCP servers for: - Repository access - File system - GitHub - SQL
metadata - Documentation - Issue tracking

## Rules

-   Never bypass specifications.
-   Prefer structured KG over free-text search.
-   Record provenance for every retrieved artifact.

## Deliverables

-   Retrieval log
-   Source provenance
-   Context summary
-   Confidence report
