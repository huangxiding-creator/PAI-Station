.class final Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;
.super Ljava/util/AbstractCollection;
.source "LinkedDeque.java"

# interfaces
.implements Ljava/util/Deque;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<E::",
        "Lcom/fasterxml/jackson/databind/util/internal/Linked<",
        "TE;>;>",
        "Ljava/util/AbstractCollection<",
        "TE;>;",
        "Ljava/util/Deque<",
        "TE;>;"
    }
.end annotation


# instance fields
.field first:Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TE;"
        }
    .end annotation
.end field

.field last:Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TE;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 0

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-direct {p0}, Ljava/util/AbstractCollection;-><init>()V

    return-void
.end method


# virtual methods
.method public add(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)Z"
        }
    .end annotation

    .line 286
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->offerLast(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result v0

    return v0
.end method

.method public bridge synthetic add(Ljava/lang/Object;)Z
    .locals 0

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    check-cast p1, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->add(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result p1

    return p1
.end method

.method public addFirst(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)V"
        }
    .end annotation

    .line 292
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->offerFirst(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 295
    return-void

    .line 293
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw v0
.end method

.method public bridge synthetic addFirst(Ljava/lang/Object;)V
    .locals 0

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    check-cast p1, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->addFirst(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    return-void
.end method

.method public addLast(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)V"
        }
    .end annotation

    .line 299
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->offerLast(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 302
    return-void

    .line 300
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw v0
.end method

.method public bridge synthetic addLast(Ljava/lang/Object;)V
    .locals 0

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    check-cast p1, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->addLast(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    return-void
.end method

.method checkNotEmpty()V
    .locals 1

    .line 160
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 163
    return-void

    .line 161
    :cond_0
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
.end method

.method public clear()V
    .locals 3

    .line 182
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .local v0, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    :goto_0
    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 183
    invoke-interface {v0}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->getNext()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v2

    .line 184
    .local v2, "next":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-interface {v0, v1}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setPrevious(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 185
    invoke-interface {v0, v1}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setNext(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 186
    move-object v0, v2

    .line 187
    .end local v2    # "next":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    goto :goto_0

    .line 188
    .end local v0    # "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    :cond_0
    iput-object v1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    iput-object v1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 189
    return-void
.end method

.method contains(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/fasterxml/jackson/databind/util/internal/Linked<",
            "*>;)Z"
        }
    .end annotation

    .line 198
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "Lcom/fasterxml/jackson/databind/util/internal/Linked<*>;"
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->getPrevious()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    if-nez v0, :cond_1

    .line 199
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->getNext()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    if-ne p1, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 198
    :goto_1
    return v0
.end method

.method public contains(Ljava/lang/Object;)Z
    .locals 1
    .param p1, "o"    # Ljava/lang/Object;

    .line 193
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    instance-of v0, p1, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    if-eqz v0, :cond_0

    move-object v0, p1

    check-cast v0, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->contains(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public descendingIterator()Ljava/util/Iterator;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator<",
            "TE;>;"
        }
    .end annotation

    .line 391
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    new-instance v0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$2;

    iget-object v1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-direct {v0, p0, v1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$2;-><init>(Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    return-object v0
.end method

.method public element()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 258
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->getFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic element()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->element()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public getFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 246
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->checkNotEmpty()V

    .line 247
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->peekFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getFirst()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->getFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public getLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 252
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->checkNotEmpty()V

    .line 253
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->peekLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getLast()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->getLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public isEmpty()Z
    .locals 1

    .line 156
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public iterator()Ljava/util/Iterator;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator<",
            "TE;>;"
        }
    .end annotation

    .line 382
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    new-instance v0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$1;

    iget-object v1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-direct {v0, p0, v1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$1;-><init>(Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    return-object v0
.end method

.method linkFirst(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)V"
        }
    .end annotation

    .line 76
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 77
    .local v0, "f":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    iput-object p1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 79
    if-nez v0, :cond_0

    .line 80
    iput-object p1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    goto :goto_0

    .line 82
    :cond_0
    invoke-interface {v0, p1}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setPrevious(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 83
    invoke-interface {p1, v0}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setNext(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 85
    :goto_0
    return-void
.end method

.method linkLast(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)V"
        }
    .end annotation

    .line 94
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 95
    .local v0, "l":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    iput-object p1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 97
    if-nez v0, :cond_0

    .line 98
    iput-object p1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    goto :goto_0

    .line 100
    :cond_0
    invoke-interface {v0, p1}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setNext(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 101
    invoke-interface {p1, v0}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setPrevious(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 103
    :goto_0
    return-void
.end method

.method public moveToBack(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)V"
        }
    .end annotation

    .line 223
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    if-eq p1, v0, :cond_0

    .line 224
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->unlink(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 225
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->linkLast(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 227
    :cond_0
    return-void
.end method

.method public moveToFront(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)V"
        }
    .end annotation

    .line 210
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    if-eq p1, v0, :cond_0

    .line 211
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->unlink(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 212
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->linkFirst(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 214
    :cond_0
    return-void
.end method

.method public offer(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)Z"
        }
    .end annotation

    .line 263
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->offerLast(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result v0

    return v0
.end method

.method public bridge synthetic offer(Ljava/lang/Object;)Z
    .locals 0

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    check-cast p1, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->offer(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result p1

    return p1
.end method

.method public offerFirst(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)Z"
        }
    .end annotation

    .line 268
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->contains(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 269
    const/4 v0, 0x0

    return v0

    .line 271
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->linkFirst(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 272
    const/4 v0, 0x1

    return v0
.end method

.method public bridge synthetic offerFirst(Ljava/lang/Object;)Z
    .locals 0

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    check-cast p1, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->offerFirst(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result p1

    return p1
.end method

.method public offerLast(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)Z"
        }
    .end annotation

    .line 277
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->contains(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 278
    const/4 v0, 0x0

    return v0

    .line 280
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->linkLast(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 281
    const/4 v0, 0x1

    return v0
.end method

.method public bridge synthetic offerLast(Ljava/lang/Object;)Z
    .locals 0

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    check-cast p1, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->offerLast(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result p1

    return p1
.end method

.method public peek()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 231
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->peekFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic peek()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->peek()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public peekFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 236
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    return-object v0
.end method

.method public bridge synthetic peekFirst()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->peekFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public peekLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 241
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    return-object v0
.end method

.method public bridge synthetic peekLast()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->peekLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public poll()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 306
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->pollFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic poll()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->poll()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public pollFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 311
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->unlinkFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public bridge synthetic pollFirst()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->pollFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public pollLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 316
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->unlinkLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public bridge synthetic pollLast()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->pollLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public pop()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 377
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->removeFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic pop()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->pop()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public push(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)V"
        }
    .end annotation

    .line 372
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->addFirst(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 373
    return-void
.end method

.method public bridge synthetic push(Ljava/lang/Object;)V
    .locals 0

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    check-cast p1, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->push(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    return-void
.end method

.method public remove()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 321
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->removeFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic remove()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->remove()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method remove(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)Z"
        }
    .end annotation

    .line 332
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->contains(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 333
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->unlink(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 334
    const/4 v0, 0x1

    return v0

    .line 336
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public remove(Ljava/lang/Object;)Z
    .locals 1
    .param p1, "o"    # Ljava/lang/Object;

    .line 327
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    instance-of v0, p1, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    if-eqz v0, :cond_0

    move-object v0, p1

    check-cast v0, Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->remove(Lcom/fasterxml/jackson/databind/util/internal/Linked;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public removeAll(Ljava/util/Collection;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "*>;)Z"
        }
    .end annotation

    .line 363
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "c":Ljava/util/Collection;, "Ljava/util/Collection<*>;"
    const/4 v0, 0x0

    .line 364
    .local v0, "modified":Z
    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 365
    .local v2, "o":Ljava/lang/Object;
    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->remove(Ljava/lang/Object;)Z

    move-result v3

    or-int/2addr v0, v3

    .line 366
    .end local v2    # "o":Ljava/lang/Object;
    goto :goto_0

    .line 367
    :cond_0
    return v0
.end method

.method public removeFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 341
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->checkNotEmpty()V

    .line 342
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->pollFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic removeFirst()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->removeFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public removeFirstOccurrence(Ljava/lang/Object;)Z
    .locals 1
    .param p1, "o"    # Ljava/lang/Object;

    .line 347
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->remove(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public removeLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 352
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->checkNotEmpty()V

    .line 353
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->pollLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic removeLast()Ljava/lang/Object;
    .locals 1

    .line 46
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->removeLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public removeLastOccurrence(Ljava/lang/Object;)Z
    .locals 1
    .param p1, "o"    # Ljava/lang/Object;

    .line 358
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->remove(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public size()I
    .locals 2

    .line 173
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    const/4 v0, 0x0

    .line 174
    .local v0, "size":I
    iget-object v1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .local v1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    :goto_0
    if-eqz v1, :cond_0

    .line 175
    add-int/lit8 v0, v0, 0x1

    .line 174
    invoke-interface {v1}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->getNext()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v1

    goto :goto_0

    .line 177
    .end local v1    # "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    :cond_0
    return v0
.end method

.method unlink(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)V"
        }
    .end annotation

    .line 136
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    .local p1, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->getPrevious()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    .line 137
    .local v0, "prev":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-interface {p1}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->getNext()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v1

    .line 139
    .local v1, "next":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    const/4 v2, 0x0

    if-nez v0, :cond_0

    .line 140
    iput-object v1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    goto :goto_0

    .line 142
    :cond_0
    invoke-interface {v0, v1}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setNext(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 143
    invoke-interface {p1, v2}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setPrevious(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 146
    :goto_0
    if-nez v1, :cond_1

    .line 147
    iput-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    goto :goto_1

    .line 149
    :cond_1
    invoke-interface {v1, v0}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setPrevious(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 150
    invoke-interface {p1, v2}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setNext(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 152
    :goto_1
    return-void
.end method

.method unlinkFirst()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 107
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 108
    .local v0, "f":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-interface {v0}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->getNext()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v1

    .line 109
    .local v1, "next":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    const/4 v2, 0x0

    invoke-interface {v0, v2}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setNext(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 111
    iput-object v1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 112
    if-nez v1, :cond_0

    .line 113
    iput-object v2, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    goto :goto_0

    .line 115
    :cond_0
    invoke-interface {v1, v2}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setPrevious(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 117
    :goto_0
    return-object v0
.end method

.method unlinkLast()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 122
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 123
    .local v0, "l":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-interface {v0}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->getPrevious()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v1

    .line 124
    .local v1, "prev":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    const/4 v2, 0x0

    invoke-interface {v0, v2}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setPrevious(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 125
    iput-object v1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->last:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 126
    if-nez v1, :cond_0

    .line 127
    iput-object v2, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->first:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    goto :goto_0

    .line 129
    :cond_0
    invoke-interface {v1, v2}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->setNext(Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    .line 131
    :goto_0
    return-object v0
.end method
