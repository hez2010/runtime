// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

// A disjoint set implementation.

/*****************************************************************************/
#ifndef _DISJOINTSETS_H_
#define _DISJOINTSETS_H_
/*****************************************************************************/

//===============================================================================

template <typename TAllocator = CompAllocator>
class DisjointSets
{
private:
    struct Node
    {
        unsigned m_parent;
        unsigned m_rank;

        Node(unsigned parent)
            : m_parent(parent)
            , m_rank(0)
        {
        }

        Node() = default;
    };

    JitExpandArray<Node> m_nodes;
    unsigned             m_numSets;
    unsigned             m_numNodes;

    unsigned FindInternal(unsigned node)
    {
        unsigned parent = m_nodes[node].m_parent;
        if (parent != node)
        {
            m_nodes[node].m_parent = parent = FindInternal(parent);
        }
        return parent;
    }

public:
    DisjointSets(TAllocator alloc, unsigned numNodes = 0)
        : m_nodes(JitExpandArray<Node>(alloc, numNodes < 8 ? 8 : numNodes))
        , m_numSets(0)
        , m_numNodes(0)
    {
        for (unsigned i = 0; i < numNodes; i++)
        {
            m_nodes[i] = Node(i);
        }
    }

    //------------------------------------------------------------------------
    // NumNodes: Returns the number of nodes.
    //
    unsigned NumNodes() const
    {
        return m_numNodes;
    }

    //------------------------------------------------------------------------
    // NumSets: Returns the number of sets.
    //
    unsigned NumSets() const
    {
        return m_numSets;
    }

    //------------------------------------------------------------------------
    // Add: Adds a new node to the disjoint sets.
    //
    unsigned Add()
    {
        m_nodes.EnsureCoversInd(m_numNodes);
        m_nodes[m_numNodes] = Node(m_numNodes);
        m_numSets++;
        return m_numNodes++;
    }

    //------------------------------------------------------------------------
    // Find: Finds the root of the set containing the node with index x.
    //
    // Arguments:
    //   node         - The index of the new node.
    //   [out] result - The index of the root of the set containing x.
    //
    // Returns:
    //   true if the node was found, false otherwise.
    //
    bool Find(unsigned node, unsigned* result) const
    {
        if (node < 0 || node >= m_numNodes)
        {
            return false;
        }

        *result = FindInternal(node);
        return true;
    }

    //------------------------------------------------------------------------
    // Union: Unions the sets containing the nodes with indices x and y.
    //
    // Arguments:
    //   x - The index of the first node.
    //   y - The index of the second node.
    //
    // Returns:
    //   true if the union was successful, false otherwise.
    //
    bool Union(unsigned x, unsigned y)
    {
        if (!Find(x, &x))
        {
            return false;
        }

        if (!Find(y, &y))
        {
            return false;
        }

        if (x == y)
        {
            return false;
        }

        if (m_nodes[y].m_rank > m_nodes[x].m_rank)
        {
            m_nodes[x].m_parent = y;
        }
        else
        {
            m_nodes[y].m_parent = x;
            if (m_nodes[x].m_rank == m_nodes[y].m_rank)
            {
                m_nodes[x].m_rank++;
            }
        }

        m_numSets--;
        return true;
    }
};

/*****************************************************************************/
#endif // _DISJOINTSETS_H_
/*****************************************************************************/
