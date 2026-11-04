.class abstract Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;
.super Ljava/lang/Object;
.source "LinkedDeque.java"

# interfaces
.implements Ljava/util/Iterator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x400
    name = "AbstractLinkedIterator"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Iterator<",
        "TE;>;"
    }
.end annotation


# instance fields
.field cursor:Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TE;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;


# direct methods
.method constructor <init>(Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;Lcom/fasterxml/jackson/databind/util/internal/Linked;)V
    .locals 0
    .param p1, "this$0"    # Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)V"
        }
    .end annotation

    .line 406
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>.AbstractLinkedIterator;"
    .local p2, "start":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    iput-object p1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;->this$0:Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 407
    iput-object p2, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;->cursor:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 408
    return-void
.end method


# virtual methods
.method abstract computeNext()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation
.end method

.method public hasNext()Z
    .locals 1

    .line 412
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>.AbstractLinkedIterator;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;->cursor:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public next()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 417
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>.AbstractLinkedIterator;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 420
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;->cursor:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 421
    .local v0, "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;->computeNext()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;->cursor:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    .line 422
    return-object v0

    .line 418
    .end local v0    # "e":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    :cond_0
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
.end method

.method public bridge synthetic next()Ljava/lang/Object;
    .locals 1

    .line 398
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>.AbstractLinkedIterator;"
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;->next()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method

.method public remove()V
    .locals 1

    .line 427
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<TE;>.AbstractLinkedIterator;"
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method
