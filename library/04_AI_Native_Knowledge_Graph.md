# 04_AI_Native_Knowledge_Graph

## Purpose

Define the deterministic AI-native Knowledge Graph (KG) that becomes the
authoritative semantic model for VisaFusion.

## Principles

-   KG is generated from approved specifications.
-   Every code artifact maps to a KG node.
-   Relationships are explicit and versioned.
-   No orphan nodes or implementations.

## Core Node Types

Requirement, Epic, Feature, Module, Page, API, Domain Entity, DTO,
Service, Repository, Table, Column, View, Stored Procedure, Function,
Job, Event, Business Rule, Validation Rule, Permission, Test Case, ADR,
Risk.

## Core Relationships

depends_on, implements, calls, reads, writes, owns, validates, secures,
migrates_to, replaces, generates, references, tested_by, documented_by.

## Synchronization Rules

Every merge updates: 1. Specification 2. Knowledge Graph 3. Architecture
4. Traceability Matrix

## Outputs

-   Mermaid graphs
-   GraphML/JSON exports
-   Traceability reports
-   Dependency reports
-   Impact analysis

## Validation

Reject changes if: - orphan nodes exist - undocumented dependencies
exist - traceability is broken
